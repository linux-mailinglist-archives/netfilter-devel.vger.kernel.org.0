Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902971D0946
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2020 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgEMG5a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 13 May 2020 02:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgEMG51 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 13 May 2020 02:57:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF4DC061A0C;
        Tue, 12 May 2020 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9a0yuZ9jbeWWLZ6wdj7/oXrc5yC9mMpHwfG04VNOeCA=; b=kgCEK11mX5oha5ZCaVeyrI15vP
        w0mhX7v/Z1M5YdhOfQPKiSdT9V3tqMpcd7pCKMnGU2ZCjX4N8McFXWgvFPkX094J9r6FuXlSW10oI
        vKKph5Ng1xaFxrzGfIL8csbOjUtOb9Z4Fk/EnutrQ5DGaXeJCscLWVNgvEWLu7EPxHB7GPpb7FP+2
        RXjpq784rVPTrfgzyL8MiHgUKVSUagZubt4xei7JVO/a2hcXjlyYtElxrHD4H3MOZYqBsRExVjKEt
        iAl8EB8CH0R52mnpJKzrVUrhdYxPwjoygazTyLuKHZlUZhGGswkbAwwmJgv8JTgJUKQY9f3BkPNl5
        GstJzwWg==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYlKX-0003Zb-19; Wed, 13 May 2020 06:57:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 10/14] fs: add a __kernel_read helper
Date:   Wed, 13 May 2020 08:56:52 +0200
Message-Id: <20200513065656.2110441-11-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513065656.2110441-1-hch@lst.de>
References: <20200513065656.2110441-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is the counterpart to __kernel_write, and skip the rw_verify_area
call compared to kernel_read.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c    | 21 +++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 8cfca5f8fc3ce..bd12af8a895c8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -430,6 +430,27 @@ ssize_t __vfs_read(struct file *file, char __user *buf, size_t count,
 		return -EINVAL;
 }
 
+ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
+{
+	mm_segment_t old_fs = get_fs();
+	ssize_t ret;
+
+	if (!(file->f_mode & FMODE_CAN_READ))
+		return -EINVAL;
+
+	if (count > MAX_RW_COUNT)
+		count =  MAX_RW_COUNT;
+	set_fs(KERNEL_DS);
+	ret = __vfs_read(file, (void __user *)buf, count, pos);
+	set_fs(old_fs);
+	if (ret > 0) {
+		fsnotify_access(file);
+		add_rchar(current, ret);
+	}
+	inc_syscr(current);
+	return ret;
+}
+
 ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
 	mm_segment_t old_fs;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21f126957c2cf..6441aaa25f8f2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3011,6 +3011,7 @@ extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, lo
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
+ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
-- 
2.26.2

