package domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class OrderItemVO {
    private String id;
    private Integer uid;
    private Integer quantity;
    private Double orderMoney;
    private String createTime;
    private String status;
    private String receiver;
    private String receiverAddress;

}
