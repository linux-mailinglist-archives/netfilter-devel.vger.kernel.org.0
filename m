Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74DE13D5
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Oct 2019 10:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbfJWIOe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Oct 2019 04:14:34 -0400
Received: from correo.us.es ([193.147.175.20]:35500 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389987AbfJWIOe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:14:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B77C711EB55
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Oct 2019 10:14:27 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A7F2ACA0F1
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Oct 2019 10:14:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9D965D190C; Wed, 23 Oct 2019 10:14:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 786CABAACC;
        Wed, 23 Oct 2019 10:14:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 23 Oct 2019 10:14:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 57B3941E4800;
        Wed, 23 Oct 2019 10:14:25 +0200 (CEST)
Date:   Wed, 23 Oct 2019 10:14:27 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables-restore: Unbreak *tables-restore
Message-ID: <20191023081427.6e4e3yoitttgeumx@salvia>
References: <20191022103446.14561-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022103446.14561-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:34:46PM +0200, Phil Sutter wrote:
> Commit 3dc433b55bbfa ("xtables-restore: Fix --table parameter check")
> installed an error check which evaluated true in all cases as all
> callers of do_command callbacks pass a pointer to a table name already.
> Attached test case passed as it tested error condition only.
> 
> Fix the whole mess by introducing a boolean to indicate whether a table
> parameter was seen already. Extend the test case to cover positive as
> well as negative behaviour and to test ebtables-restore and
> ip6tables-restore as well. Also add the required checking code to the
> latter since the original commit missed it.
> 
> Fixes: 3dc433b55bbfa ("xtables-restore: Fix --table parameter check")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
