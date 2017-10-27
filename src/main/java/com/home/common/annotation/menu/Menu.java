package com.home.common.annotation.menu;

import com.home.common.types.MenuTypes;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(value = RetentionPolicy.RUNTIME)
public @interface Menu {

	public MenuTypes type();
}
