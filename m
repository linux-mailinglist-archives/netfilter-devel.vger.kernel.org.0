Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 361FE11310D
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2019 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfLDRrQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Dec 2019 12:47:16 -0500
Received: from correo.us.es ([193.147.175.20]:37142 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfLDRrQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:47:16 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 065D44DE727
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Dec 2019 18:47:13 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ED5B4DA70B
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Dec 2019 18:47:12 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E179BDA70A; Wed,  4 Dec 2019 18:47:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D07F9DA702;
        Wed,  4 Dec 2019 18:47:10 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 04 Dec 2019 18:47:10 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AC1424265A5A;
        Wed,  4 Dec 2019 18:47:10 +0100 (CET)
Date:   Wed, 4 Dec 2019 18:47:10 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 2/2] xtables-restore: Fix parser feed from line
 buffer
Message-ID: <20191204174710.ory3vtyyj6t6lwmo@salvia>
References: <20191204090606.2088-1-phil@nwl.cc>
 <20191204090606.2088-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204090606.2088-2-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Dec 04, 2019 at 10:06:06AM +0100, Phil Sutter wrote:
> When called with --noflush, xtables-restore would trip over chain lines:
> Parser uses strtok() to separate chain name, policy and counters which
> inserts nul-chars into the source string. Therefore strlen() can't be
> used anymore to find end of line. Fix this by caching line length before
> calling xtables_restore_parse_line().
> 
> Fixes: 09cb517949e69 ("xtables-restore: Improve performance of --noflush operation")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
