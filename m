Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADE613DB49
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jan 2020 14:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgAPNRb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jan 2020 08:17:31 -0500
Received: from correo.us.es ([193.147.175.20]:37568 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAPNRb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:17:31 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0147B18CE7C
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jan 2020 14:17:30 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E4D47DA718
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jan 2020 14:17:29 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DA3BADA703; Thu, 16 Jan 2020 14:17:29 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CD106DA705;
        Thu, 16 Jan 2020 14:17:27 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 16 Jan 2020 14:17:27 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B209242EF9E0;
        Thu, 16 Jan 2020 14:17:27 +0100 (CET)
Date:   Thu, 16 Jan 2020 14:17:27 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 1/2] tests: shell: Search diff tool once and for all
Message-ID: <20200116131727.pynbcqhtnzkksrux@salvia>
References: <20200114164630.2492-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114164630.2492-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:46:29PM +0100, Phil Sutter wrote:
> Instead of calling 'which diff' over and over again, just detect the
> tool's presence in run-tests.sh and pass $DIFF to each testcase just
> like with nft binary.
> 
> Fall back to using 'true' command to avoid the need for any conditional
> calling in test cases.
> 
> While being at it, unify potential diff calls so that a string
> comparison in shell happens irrespective of diff presence.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
