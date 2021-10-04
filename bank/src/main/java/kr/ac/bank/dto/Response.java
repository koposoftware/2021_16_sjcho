package kr.ac.bank.dto;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Response<T> {
	private int code;
	private String msg;
	private T data;
}
