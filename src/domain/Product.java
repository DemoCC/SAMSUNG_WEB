package domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data   // Get and Set
@NoArgsConstructor  //无参构造方法
@AllArgsConstructor //带参构造方法

public class Product {
    private Integer id;
    private String name;
    private Double price;
    private String color;
    private String type;
    private Integer stock;
    private String url;

}
