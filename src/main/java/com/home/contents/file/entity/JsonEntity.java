package com.home.contents.file.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "json")
public class JsonEntity implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = -7059949562757908288L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "seq")
    private Long seq;

    @Column(name = "json")
    private String json;

}
