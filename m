Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF3178B38B
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Aug 2023 16:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjH1OsD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Aug 2023 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjH1Orf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D65139
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693233984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYpQ0+QcJ+GNFdKXloa/amyKBRzjG+1VoD3RfI/XlTw=;
        b=KjYX3akNgwmeleXYb0tmJfDX7XF9J1tVAPxCR1oTRNEvKDWNp2TvJxFzLxIU4Sa4o+hXyr
        vLNt1BxSAJnPzkyKngK9tuCH9IXRzfjx75XGETolEgc1fDJV/e9LR0oN5eKAVvmzyo9jyH
        f6k8FyFuGViB5v6hvVJSA9/9bMMfaA0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-AJeclhMMNpa6ph6eokY79A-1; Mon, 28 Aug 2023 10:46:22 -0400
X-MC-Unique: AJeclhMMNpa6ph6eokY79A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6609E3828883
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Aug 2023 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9F240D2839;
        Mon, 28 Aug 2023 14:46:21 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft 1/8] netlink: avoid "-Wenum-conversion" warning in dtype_map_from_kernel()
Date:   Mon, 28 Aug 2023 16:43:51 +0200
Message-ID: <20230828144441.3303222-2-thaller@redhat.com>
In-Reply-To: <20230828144441.3303222-1-thaller@redhat.com>
References: <20230828144441.3303222-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Clang warns:

    netlink.c:806:26: error: implicit conversion from enumeration type 'enum nft_data_types' to different enumeration type 'enum datatypes' [-Werror,-Wenum-conversion]
                    return datatype_lookup(type);
                           ~~~~~~~~~~~~~~~ ^~~~

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 src/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netlink.c b/src/netlink.c
index e1904a99d3ba..1afe162ec79b 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -803,7 +803,7 @@ static const struct datatype *dtype_map_from_kernel(enum nft_data_types type)
 	default:
 		if (type & ~TYPE_MASK)
 			return concat_type_alloc(type);
-		return datatype_lookup(type);
+		return datatype_lookup((enum datatypes) type);
 	}
 }
 
-- 
2.41.0

