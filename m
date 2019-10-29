Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A02E87B7
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Oct 2019 13:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfJ2MHr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Oct 2019 08:07:47 -0400
Received: from correo.us.es ([193.147.175.20]:44614 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2MHr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:07:47 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CCD7B1694B2
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Oct 2019 13:07:41 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C0042CA0F3
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Oct 2019 13:07:41 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B5817CA0F1; Tue, 29 Oct 2019 13:07:41 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A32C6B8004;
        Tue, 29 Oct 2019 13:07:39 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 29 Oct 2019 13:07:39 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7E9CB42EE39D;
        Tue, 29 Oct 2019 13:07:39 +0100 (CET)
Date:   Tue, 29 Oct 2019 13:07:41 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests/py: Fix test script for Python3 tempfile
Message-ID: <20191029120741.kwx4w7droeqlhqj4@salvia>
References: <20191029112508.16502-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029112508.16502-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:25:08PM +0100, Phil Sutter wrote:
> When instantiating a temporary file using tempfile's TemporaryFile()
> constructor, the resulting object's 'name' attribute is of type int.
> This in turn makes print_msg() puke while trying to concatenate string
> and int using '+' operator.
> 
> Fix this by using format strings consequently, thereby cleaning up code
> a bit.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
