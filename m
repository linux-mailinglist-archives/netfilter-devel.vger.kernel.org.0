Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E54EB1A2
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfJaNwo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 09:52:44 -0400
Received: from correo.us.es ([193.147.175.20]:39126 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfJaNwo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:52:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DDE0E114802
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 14:52:39 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CF71821FF7
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 14:52:39 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C4F05DA4CA; Thu, 31 Oct 2019 14:52:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CDBCDFB362;
        Thu, 31 Oct 2019 14:52:37 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 31 Oct 2019 14:52:37 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AA08F42EE38E;
        Thu, 31 Oct 2019 14:52:37 +0100 (CET)
Date:   Thu, 31 Oct 2019 14:52:39 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 2/2] Deprecate untyped data setters
Message-ID: <20191031135239.s2dyibgrrcfffb6u@salvia>
References: <20191030174948.12493-1-phil@nwl.cc>
 <20191030174948.12493-2-phil@nwl.cc>
 <20191031124920.4p2frkvfwgktaxqz@salvia>
 <20191031134321.GC8531@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031134321.GC8531@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:43:21PM +0100, Phil Sutter wrote:
> On Thu, Oct 31, 2019 at 01:49:20PM +0100, Pablo Neira Ayuso wrote:
> > On Wed, Oct 30, 2019 at 06:49:48PM +0100, Phil Sutter wrote:
> > > These functions make assumptions on size of passed data pointer and
> > > therefore tend to hide programming mistakes. Instead either one of the
> > > type-specific setters or the generic *_set_data() setter should be used.
> > 
> > Please, confirm that the existing iptables / nft codebase will not hit
> > compilation warnings because of deprecated functions.
> 
> Yes, current code base does not use those functions.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
