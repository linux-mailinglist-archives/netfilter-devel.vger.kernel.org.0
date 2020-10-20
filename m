Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8107228B447
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Oct 2020 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgJLMBX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Oct 2020 08:01:23 -0400
Received: from correo.us.es ([193.147.175.20]:37850 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388209AbgJLMBX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:01:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7435BDA707
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 14:01:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D3C6DA704
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 14:01:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 52B16DA78F; Mon, 12 Oct 2020 14:01:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5E9A7DA73F;
        Mon, 12 Oct 2020 14:01:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 12 Oct 2020 14:01:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3ED0742EE38E;
        Mon, 12 Oct 2020 14:01:19 +0200 (CEST)
Date:   Mon, 12 Oct 2020 14:01:18 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 02/10] nft: Implement nft_chain_foreach()
Message-ID: <20201012120118.GB26845@salvia>
References: <20200923174849.5773-1-phil@nwl.cc>
 <20200923174849.5773-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923174849.5773-3-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 23, 2020 at 07:48:41PM +0200, Phil Sutter wrote:
> This is just a fancy wrapper around nftnl_chain_list_foreach() with the
> added benefit of detecting invalid table names or uninitialized chain
> lists. This in turn allows to drop the checks in flush_rule_cache() and
> ignore the return code of nft_chain_foreach() as it fails only if the
> dropped checks had failed, too.

At quick glance, this is reducing the LoC.

However, I'm not sure this is better, before this code:

1) You fetch the list
2) You use it from several spots in the function

with this patch you might look up for the chain list several times in
the same function.

+int nft_chain_foreach(struct nft_handle *h, const char *table,                
+                   int (*cb)(struct nftnl_chain *c, void *data),              
+                   void *data)                                                
+{                                                                             
+     const struct builtin_table *t;                                           
+                                                                              
+     t = nft_table_builtin_find(h, table);                                    
+     if (!t)                                                                  
+             return -1;                                                       
+                                                                              
+     if (!h->cache->table[t->type].chains)                                    
+             return -1;                                                       
+                                                                              
+     return nftnl_chain_list_foreach(h->cache->table[t->type].chains,         
+                                     cb, data);                               
+}

I can also see calls to:

nft_chain_find(h, table, chain);

and

nft_chain_foreach(...)

from the same function.

This patch also updates paths in very different ways, there is no
common idiom being replaced.
