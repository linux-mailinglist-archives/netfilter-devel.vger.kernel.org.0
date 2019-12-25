Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB2912A951
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Dec 2019 00:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLYXSc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Dec 2019 18:18:32 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:53973 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbfLYXSb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Dec 2019 18:18:31 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id C1B6B43FCFC
        for <netfilter-devel@vger.kernel.org>; Thu, 26 Dec 2019 10:18:16 +1100 (AEDT)
Received: (qmail 30009 invoked by uid 501); 25 Dec 2019 23:18:15 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue] src: doc: Eliminate doxygen warnings from libnetfilter_queue.c
Date:   Thu, 26 Dec 2019 10:18:15 +1100
Message-Id: <20191225231815.29967-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=pxVhFHJ0LMsA:10 a=RSmzAf-M6YYA:10 a=PO7r1zJSAAAA:8
        a=rodX5-eLMr3gAVNZdKQA:9 a=uopIpIcpaHI6gYBe:21 a=easaShgky_icMfZf:21
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

- Change items of the form #<word> to "\b <word>".
  (#<word> is rather obscurely documented to be a reference to a documented
           entity)
- Re-work text wrapping in above change to keep lines within 80cc
- Add 2 missing \param directives

12 warnings fixed

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/libnetfilter_queue.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/libnetfilter_queue.c b/src/libnetfilter_queue.c
index 3f70ba2..3cf9653 100644
--- a/src/libnetfilter_queue.c
+++ b/src/libnetfilter_queue.c
@@ -513,10 +513,10 @@ int nfq_unbind_pf(struct nfq_handle *h, uint16_t pf)
  * \return a nfq_q_handle pointing to the newly created queue
  *
  * Creates a new queue handle, and returns it.  The new queue is identified by
- * #num, and the callback specified by #cb will be called for each enqueued
- * packet.  The #data argument will be passed unchanged to the callback.  If
- * a queue entry with id #num already exists, this function will return failure
- * and the existing entry is unchanged.
+ * \b num, and the callback specified by \b cb will be called for each enqueued
+ * packet.  The \b data argument will be passed unchanged to the callback.  If
+ * a queue entry with id \b num already exists,
+ * this function will return failure and the existing entry is unchanged.
  *
  * The nfq_callback type is defined in libnetfilter_queue.h as:
  * \verbatim
@@ -651,7 +651,7 @@ int nfq_set_mode(struct nfq_q_handle *qh, uint8_t mode, uint32_t range)
  * nfq_set_queue_flags - set flags (options) for the kernel queue
  * \param qh Netfilter queue handle obtained by call to nfq_create_queue().
  * \param mask specifies which flag bits to modify
- * \param flag bitmask of flags
+ * \param flags bitmask of flags
  *
  * Existing flags, that you may want to combine, are:
  *
@@ -834,7 +834,7 @@ static int __set_verdict(struct nfq_q_handle *qh, uint32_t id,
  * \param qh Netfilter queue handle obtained by call to nfq_create_queue().
  * \param id	ID assigned to packet by netfilter.
  * \param verdict verdict to return to netfilter (NF_ACCEPT, NF_DROP)
- * \param data_len number of bytes of data pointed to by #buf
+ * \param data_len number of bytes of data pointed to by \b buf
  * \param buf the buffer that contains the packet data
  *
  * Can be obtained by:
@@ -867,7 +867,7 @@ int nfq_set_verdict(struct nfq_q_handle *qh, uint32_t id,
  * \param id	ID assigned to packet by netfilter.
  * \param verdict verdict to return to netfilter (NF_ACCEPT, NF_DROP)
  * \param mark mark to put on packet
- * \param data_len number of bytes of data pointed to by #buf
+ * \param data_len number of bytes of data pointed to by \b buf
  * \param buf the buffer that contains the packet data
  */
 EXPORT_SYMBOL
@@ -886,7 +886,7 @@ int nfq_set_verdict2(struct nfq_q_handle *qh, uint32_t id,
  * \param verdict verdict to return to netfilter (NF_ACCEPT, NF_DROP)
  *
  * Unlike nfq_set_verdict, the verdict is applied to all queued packets
- * whose packet id is smaller or equal to #id.
+ * whose packet id is smaller or equal to \b id.
  *
  * batch support was added in Linux 3.1.
  * These functions will fail silently on older kernels.
@@ -920,7 +920,7 @@ int nfq_set_verdict_batch2(struct nfq_q_handle *qh, uint32_t id,
  * \param id	ID assigned to packet by netfilter.
  * \param verdict verdict to return to netfilter (NF_ACCEPT, NF_DROP)
  * \param mark the mark to put on the packet, in network byte order.
- * \param data_len number of bytes of data pointed to by #buf
+ * \param data_len number of bytes of data pointed to by \b buf
  * \param buf the buffer that contains the packet data
  *
  * \return -1 on error; >= 0 otherwise.
@@ -1213,6 +1213,7 @@ struct nfqnl_msg_packet_hw *nfq_get_packet_hw(struct nfq_data *nfad)
 /**
  * nfq_get_uid - get the UID of the user the packet belongs to
  * \param nfad Netlink packet data handle passed to callback function
+ * \param uid Set to UID on return
  *
  * \warning If the NFQA_CFG_F_GSO flag is not set, then fragmented packets
  * may be pushed into the queue. In this case, only one fragment will have the
@@ -1233,6 +1234,7 @@ int nfq_get_uid(struct nfq_data *nfad, uint32_t *uid)
 /**
  * nfq_get_gid - get the GID of the user the packet belongs to
  * \param nfad Netlink packet data handle passed to callback function
+ * \param gid Set to GID on return
  *
  * \warning If the NFQA_CFG_F_GSO flag is not set, then fragmented packets
  * may be pushed into the queue. In this case, only one fragment will have the
-- 
2.14.5

