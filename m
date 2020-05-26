Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487561D7BF5
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2020 16:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgERO51 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 May 2020 10:57:27 -0400
Received: from correo.us.es ([193.147.175.20]:43570 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgERO50 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 May 2020 10:57:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6E51611773C
        for <netfilter-devel@vger.kernel.org>; Mon, 18 May 2020 16:57:25 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 60E60DA707
        for <netfilter-devel@vger.kernel.org>; Mon, 18 May 2020 16:57:25 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 60486DA714; Mon, 18 May 2020 16:57:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6FC8BDA707;
        Mon, 18 May 2020 16:57:23 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 18 May 2020 16:57:23 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5171142EF42B;
        Mon, 18 May 2020 16:57:23 +0200 (CEST)
Date:   Mon, 18 May 2020 16:57:23 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 0/2] Critical: Unbreak nfnl_osf tool
Message-ID: <20200518145723.GA1999@salvia>
References: <20200515140330.13669-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515140330.13669-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 15, 2020 at 04:03:28PM +0200, Phil Sutter wrote:
> No changes in patch 1, it is still the right fix for the problem and
> restores original behaviour.
> 
> Patch 2 changed according to feedback:
> 
> - Elaborate on why there are duplicates in pf.os in the first place.
> 
> - Ignore ENOENT when deleting. Since the code ignores EEXIST when
>   creating, reporting this was asymmetrical behaviour.
> 
> - Fix for ugly error message when user didn't specify '-f' option.

This looks good.

Thanks for addressing my feedback.
