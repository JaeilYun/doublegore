package com.home.common.annotation.breadcrumb;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(value = RetentionPolicy.RUNTIME)
public @interface Breadcrumb {

	public String[] values();
}
