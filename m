Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAD143D55
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jan 2020 13:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgAUMzw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jan 2020 07:55:52 -0500
Received: from correo.us.es ([193.147.175.20]:34936 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbgAUMzw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:55:52 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DFE2F172C89
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jan 2020 13:55:50 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D1523DA70E
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jan 2020 13:55:50 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C6C56DA716; Tue, 21 Jan 2020 13:55:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CCD4ADA717;
        Tue, 21 Jan 2020 13:55:48 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 Jan 2020 13:55:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B014942EE38E;
        Tue, 21 Jan 2020 13:55:48 +0100 (CET)
Date:   Tue, 21 Jan 2020 13:55:47 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/4] netlink: Fix leaks in netlink_parse_cmp()
Message-ID: <20200121125547.ukzmnq4os6a44e2w@salvia>
References: <20200120162540.9699-1-phil@nwl.cc>
 <20200120162540.9699-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120162540.9699-3-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:25:38PM +0100, Phil Sutter wrote:
> This fixes several problems at once:
> 
> * Err path would leak expr 'right' in two places and 'left' in one.
> * Concat case would leak 'right' by overwriting the pointer. Introduce a
>   temporary variable to hold the new pointer.
> 
> Fixes: 6377380bc265f ("netlink_delinearize: handle relational and lookup concat expressions")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
