Return-Path: <netfilter-devel+bounces-11520-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIrkGZD9y2mcNAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11520-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 19:00:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5B436DA07
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 18:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A85113094006
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D93042668E;
	Tue, 31 Mar 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEGNpU6C"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C479425CD9
	for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2026 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975850; cv=none; b=Q9aAf7ovFBQ5J0cp4rI9W+zofAagZw9uGYyI84GtIIMuqUUIJFHSQkmb8s3kbJC/5KeiUT6aQVvX7cICsPeYS3yz+P3YBL4yRKApVlTdhnVCpqKSUFDX1e/es7G54qyytp68bKij3uArxhGYSHydmWqkRjp0KcEOjS2CSgZft3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975850; c=relaxed/simple;
	bh=Wx3rCjft+f2xsQztl0u/tUkCuC3NJhEmQV+HjeE0iDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkhGGOFHBuXtdIr5ZhW33R0bpUrPWGV4gGRh4D50MDL7FRNtr8HNjzFKNEcw6ehX5C4A3cICY42/LZ8SPwoEbCxDE8F+eHyzN6t32OXJqNEHPAilqvijF6130RpVcvumIJ2gDfbguoZ6IGURuc9T7xUsuO8k1cxohMNu14UpEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEGNpU6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774975848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NM71jEPy1P0WHGHdPzJuToYXqWbTBefaY9NqYpg0IOU=;
	b=DEGNpU6ChfjLoNW2dkyowSlFIh2W8ERWnEE52G7IOUK17S87akUxQVKOtu9sujDQnj1UuX
	/KcHsAmJFkNGO2etv1ubmpv+4QqwkC8khzFXFWO1eBNQcsfOP2fsfEb5R/6rIA4nuiO3nN
	22c7fK/WAALMKdw/JoMmsT5J0sK6Hd4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-QYj4AEahP0GCg0Tqw5U3Wg-1; Tue,
 31 Mar 2026 12:50:44 -0400
X-MC-Unique: QYj4AEahP0GCg0Tqw5U3Wg-1
X-Mimecast-MFC-AGG-ID: QYj4AEahP0GCg0Tqw5U3Wg_1774975841
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F054619560B1;
	Tue, 31 Mar 2026 16:50:39 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8787A180075B;
	Tue, 31 Mar 2026 16:50:36 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Frederic Weisbecker <frederic@kernel.org>,
	Chen Ridong <chenridong@huawei.com>,
	Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	sheviks <sheviks@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v2 1/2] sched/isolation: Make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
Date: Tue, 31 Mar 2026 12:50:14 -0400
Message-ID: <20260331165015.2777765-2-longman@redhat.com>
In-Reply-To: <20260331165015.2777765-1-longman@redhat.com>
References: <20260331165015.2777765-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11520-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B5B436DA07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 041ee6f3727a ("kthread: Rely on HK_TYPE_DOMAIN for preferred
affinity management"), kthreads default to use the HK_TYPE_DOMAIN
cpumask. IOW, it is no longer affected by the setting of the nohz_full
boot kernel parameter.

That means HK_TYPE_KTHREAD should now be an alias of HK_TYPE_DOMAIN
instead of HK_TYPE_KERNEL_NOISE to correctly reflect the current kthread
behavior. Make the change as HK_TYPE_KTHREAD is still being used in
some networking code.

Fixes: 041ee6f3727a ("kthread: Rely on HK_TYPE_DOMAIN for preferred affinity management")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/isolation.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index dc3975ff1b2e..cf0fd03dd7a2 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -20,6 +20,11 @@ enum hk_type {
 	HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_MAX,
 
+	/*
+	 * HK_TYPE_KTHREAD is now an alias of HK_TYPE_DOMAIN
+	 */
+	HK_TYPE_KTHREAD = HK_TYPE_DOMAIN,
+
 	/*
 	 * The following housekeeping types are only set by the nohz_full
 	 * boot commandline option. So they can share the same value.
@@ -29,7 +34,6 @@ enum hk_type {
 	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
 };
 
 #ifdef CONFIG_CPU_ISOLATION
-- 
2.53.0


