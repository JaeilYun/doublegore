package com.home.contents.note.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
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
@Table(name = "note_file")
public class NoteFileEntity implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1995985557900983386L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "seq")
    private Long seq;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_key")
    private String fileKey;

    @Column(name = "content_type")
    private String contentType;

    @Column(name = "file_path")
    private String filePath;

    @Column(name = "file_size")
    private Long fileSize;

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

    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "note_seq")
    private NoteEntity noteEntity;
}
