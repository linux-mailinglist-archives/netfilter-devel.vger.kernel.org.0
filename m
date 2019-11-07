Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7959BF2AEA
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Nov 2019 10:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfKGJlg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 7 Nov 2019 04:41:36 -0500
Received: from correo.us.es ([193.147.175.20]:50770 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKGJlg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:41:36 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 18C42120823
        for <netfilter-devel@vger.kernel.org>; Thu,  7 Nov 2019 10:41:32 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0AA32B7FFE
        for <netfilter-devel@vger.kernel.org>; Thu,  7 Nov 2019 10:41:32 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 00738B7FF2; Thu,  7 Nov 2019 10:41:31 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C9703DA840;
        Thu,  7 Nov 2019 10:41:26 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 07 Nov 2019 10:41:26 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A324E41E4801;
        Thu,  7 Nov 2019 10:41:26 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:41:28 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] libnftables: Store top_scope in struct nft_ctx
Message-ID: <20191107094128.dublkx42a7m5wbm2@salvia>
References: <20191106140001.2539-1-phil@nwl.cc>
 <20191106142232.GS15063@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106142232.GS15063@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:22:32PM +0100, Phil Sutter wrote:
> On Wed, Nov 06, 2019 at 03:00:01PM +0100, Phil Sutter wrote:
> > Allow for interactive sessions to make use of defines. Since parser is
> > initialized for each line, top scope defines didn't persist although
> > they are actually useful for stuff like:
> > 
> > | # nft -i
> > | define goodports = { 22, 23, 80, 443 }
> > | add rule inet t c tcp dport $goodports accept
> > | add rule inet t c tcp sport $goodports accept
> > 
> > While being at it, introduce scope_alloc() and scope_free().
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> > Changes since v1:
> > - Fix usage example in commit message.
> > - Add scope_{alloc,free} functions.
> 
> Minor correction, this is actually v3 and above are the changes since
> v2. /o\

For this v3.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
