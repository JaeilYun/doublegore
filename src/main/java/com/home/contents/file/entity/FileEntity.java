package com.home.contents.file.entity;

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
@Table(name = "file")
public class FileEntity implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 4003687043490294638L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "seq")
    private Long seq;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_path")
    private String filePath;

    @Column(name = "file_thumb_path")
    private String fileThumbPath;

    @Column(name = "file_full_path")
    private String fileFullPath;

    @Column(name = "file_size")
    private Long fileSize;

    @Column(name = "file_type")
    private String fileType;

    @Column(name = "file_key")
    private String fileKey;

    @Column(name = "node_id")
    private String nodeId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date")
    private Date createdDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_date")
    private Date updatedDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "deleted_date")
    private Date deletedDate;

    @Column(name = "is_deleted")
    private String isDeleted;
}
