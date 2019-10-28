Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1FBE7377
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2019 15:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbfJ1ORK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Oct 2019 10:17:10 -0400
Received: from correo.us.es ([193.147.175.20]:48742 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbfJ1ORK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:17:10 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C28E311EB85
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 15:17:05 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B456AB7FFE
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 15:17:05 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AA131B7FF9; Mon, 28 Oct 2019 15:17:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CA73966DD;
        Mon, 28 Oct 2019 15:17:03 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 28 Oct 2019 15:17:03 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A804E42EE396;
        Mon, 28 Oct 2019 15:17:03 +0100 (CET)
Date:   Mon, 28 Oct 2019 15:17:05 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 00/10] Reduce code size around arptables-nft
Message-ID: <20191028141705.nitbzqidmmtjaxcg@salvia>
References: <20191028140431.13882-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028140431.13882-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 28, 2019 at 03:04:21PM +0100, Phil Sutter wrote:
> A review of xtables-arp.c exposed a significant amount of dead, needless
> or duplicated code. This series deals with some low hanging fruits. Most
> of the changes affect xtables-arp.c and nft-arp.c only, but where common
> issues existed or code was to be shared, other files are touched as
> well.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
