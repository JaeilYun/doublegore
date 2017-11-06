package com.home.contents.note.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoteForm {
	Long seq;
	String title;
	Long select;
	String content;
	String[] attachImage;
}
