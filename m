Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0734B3DD
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Mar 2021 03:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhC0CzV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 26 Mar 2021 22:55:21 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:52426 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhC0CzP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:55:15 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id D48809801F9;
        Sat, 27 Mar 2021 10:55:08 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] netfilter: ipset: Remove duplicate declaration
Date:   Sat, 27 Mar 2021 10:54:47 +0800
Message-Id: <20210327025454.917202-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSxkaSEhLSkxPQkJNVkpNSk1DSkhMS0JKTkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6Lgw6Iz8cLDMaLRI0LQ9R
        MTVPCzxVSlVKTUpNQ0pITEtCTktJVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTUJNNwY+
X-HM-Tid: 0a78719b5705d992kuwsd48809801f9
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

struct ip_set is declared twice. One is declared at 79th line,
so remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/netfilter/ipset/ip_set.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index 46d9a0c26c67..10279c4830ac 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -124,8 +124,6 @@ struct ip_set_ext {
 	bool target;
 };
 
-struct ip_set;
-
 #define ext_timeout(e, s)	\
 ((unsigned long *)(((void *)(e)) + (s)->offset[IPSET_EXT_ID_TIMEOUT]))
 #define ext_counter(e, s)	\
-- 
2.25.1

