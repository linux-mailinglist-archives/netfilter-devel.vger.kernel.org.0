Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05EF3F33DC
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Aug 2021 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhHTScn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Aug 2021 14:32:43 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:50166 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhHTScm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:32:42 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 14:32:42 EDT
X-Interia-R: Interia
X-Interia-R-IP: 77.46.101.67
X-Interia-R-Helo: <[172.16.16.104]>
Received: from [172.16.16.104] (PC-77-46-101-67.euro-net.pl [77.46.101.67])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by poczta.interia.pl (INTERIA.PL) with ESMTPSA
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Aug 2021 20:24:36 +0200 (CEST)
Reply-To: grzegorz.kuczynski@interia.eu
To:     netfilter-devel@vger.kernel.org
From:   =?UTF-8?Q?Grzegorz_Kuczy=c5=84ski?= <grzegorz.kuczynski@interia.eu>
Subject: [PATCH] xtables-addons 3.18 condition - Improved network namespace
 support
Message-ID: <a2e36a8e-939f-453d-8a0d-d6ef61bbf280@interia.eu>
Date:   Fri, 20 Aug 2021 20:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1629483876;
        bh=eqtX+lxdubOI1Fef6UDyDfA8nWm7xQncv0YRDvYZm7Q=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Reply-To:To:From:
         Subject:Message-ID:Date:User-Agent:MIME-Version:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Interia-Antivirus;
        b=faoNdyAYtou7KPHUPmTN56d46E6qUS1hPiTJaSi/ObmqV62q9UrKbTjIpV2XlF6Qp
         /nAd3Wmql+u/TQik++b0zjh7GihB/RVdr4QaXx5yU5sqw1KjNrB74jgatLli95ZBQM
         sIPTCe7kZGPt/y4bPvr41iXL2mzQrz3YbekwhOhY=
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello
A few years ago I add network namespace to extension condition.
I review this changes again and make changes again.
This is better version.


diff --git a/extensions/xt_condition.c b/extensions/xt_condition.c
index 8227c5d..c5b0df3 100644
--- a/extensions/xt_condition.c
+++ b/extensions/xt_condition.c
@@ -65,12 +65,11 @@ static DEFINE_MUTEX(proc_lock);
 struct condition_net {
        struct list_head conditions_list;
        struct proc_dir_entry *proc_net_condition;
-       bool after_clear;
 };
 
 static int condition_net_id;
 
-static inline struct condition_net *condition_pernet(struct net *net)
+static inline struct condition_net *get_condition_pernet(struct net *net)
 {
        return net_generic(net, condition_net_id);
 }
@@ -132,7 +131,7 @@ static int condition_mt_check(const struct
xt_mtchk_param *par)
 {
        struct xt_condition_mtinfo *info = par->matchinfo;
        struct condition_variable *var;
-       struct condition_net *condition_net = condition_pernet(par->net);
+       struct condition_net *condition_net =
get_condition_pernet(par->net);
 
        /* Forbid certain names */
        if (*info->name == '\0' || *info->name == '.' ||
@@ -190,13 +189,10 @@ static void condition_mt_destroy(const struct
xt_mtdtor_param *par)
 {
        const struct xt_condition_mtinfo *info = par->matchinfo;
        struct condition_variable *var = info->condvar;
-       struct condition_net *cnet = condition_pernet(par->net);
-
-       if (cnet->after_clear)
-               return;
-
+       struct condition_net *cnet = get_condition_pernet(par->net);
+      
        mutex_lock(&proc_lock);
-       if (--var->refcount == 0) {
+       if (--var->refcount == 0 &&
!list_empty_careful(&cnet->conditions_list)) {
                list_del(&var->list);
                remove_proc_entry(var->name, cnet->proc_net_condition);
                mutex_unlock(&proc_lock);
@@ -233,18 +229,17 @@ static const char *const dir_name = "nf_condition";
 
 static int __net_init condition_net_init(struct net *net)
 {
-       struct condition_net *condition_net = condition_pernet(net);
+       struct condition_net *condition_net = get_condition_pernet(net);
        INIT_LIST_HEAD(&condition_net->conditions_list);
        condition_net->proc_net_condition = proc_mkdir(dir_name,
net->proc_net);
        if (condition_net->proc_net_condition == NULL)
                return -EACCES;
-       condition_net->after_clear = 0;
        return 0;
 }
 
 static void __net_exit condition_net_exit(struct net *net)
 {
-       struct condition_net *condition_net = condition_pernet(net);
+       struct condition_net *condition_net = get_condition_pernet(net);
        struct list_head *pos, *q;
        struct condition_variable *var = NULL;
 
@@ -256,7 +251,6 @@ static void __net_exit condition_net_exit(struct net
*net)
                kfree(var);
        }
        mutex_unlock(&proc_lock);
-       condition_net->after_clear = true;
 }
 
 static struct pernet_operations condition_net_ops = {


-- 
Grzegorz Kuczyński

