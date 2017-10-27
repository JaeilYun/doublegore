package com.home.contents.note.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "note_category")
public class NoteCategoryEntity implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1705928558965867186L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "seq")
    private Long seq;

    @Column(name = "type")
    private String type;
}
