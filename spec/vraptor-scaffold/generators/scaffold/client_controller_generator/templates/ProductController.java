package app.controller;

import java.util.List;

import app.model.Product;
import app.repositories.ProductRepository;
import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.view.Results;
import com.google.gson.Gson;

@Resource
public class ProductController {

	private final Result result;
	private final ProductRepository repository;
	private final Validator validator;
  private final Gson json;
	
	ProductController(Result result, ProductRepository repository, Validator validator) {
		this.result = result;
		this.repository = repository;
		this.validator = validator;
    this.json = new Gson();
	}
	
	@Get("/products")
	public List<Product> index() {
    List<Product > list = repository.findAll();
    result.include("json", json.toJson(list));
    return repository.findAll();
  }

  @Get("/products.json")
  public void indexJson() {
    result.use(Results.json()).withoutRoot().from(index()).recursive().serialize();
  }
	
	@Post("/products")
	public void create(Product product) {
		validator.validate(product);
		validator.onErrorUsePageOf(this).newProduct();
		repository.create(product);
		result.redirectTo(this).index();
	}
	
	@Get("/products/new")
	public Product newProduct() {
    Product product = new Product();
    result.include("json", json.toJson(product));
    return product;
	}
	
	@Put("/products")
	public void update(Product product) {
		validator.validate(product);
		validator.onErrorUsePageOf(this).edit(product);
		repository.update(product);
		result.redirectTo(this).index();
	}
	
	@Get("/products/{product.id}/edit")
	public Product edit(Product product) {
    product = repository.find(product.getId());
    result.include("json", json.toJson(product));
    return product;
	}

	@Get("/products/{product.id}.json")
	public void showJson(Product product) {
    serialize(show(product));
	}

	@Get("/products/{product.id}")
	public Product show(Product product) {
    product = repository.find(product.getId());
    result.include("json", json.toJson(product));
    return product;
	}

	@Delete("/products/{product.id}")
	public void destroy(Product product) {
		repository.destroy(repository.find(product.getId()));
		result.redirectTo(this).index();  
	}

  private void serialize(Object object) {
    result.use(Results.json()).withoutRoot().from(object).recursive().serialize();
  }
}
