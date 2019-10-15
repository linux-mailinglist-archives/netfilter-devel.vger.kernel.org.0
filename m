Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A91D7118
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfJOIc5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 04:32:57 -0400
Received: from correo.us.es ([193.147.175.20]:34654 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfJOIc5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:32:57 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B64A4E0439
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 10:32:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A5DDFFF6E4
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 10:32:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A5043FF6C4; Tue, 15 Oct 2019 10:32:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 90A074C3C3;
        Tue, 15 Oct 2019 10:32:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 15 Oct 2019 10:32:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 62C8641E4801;
        Tue, 15 Oct 2019 10:32:50 +0200 (CEST)
Date:   Tue, 15 Oct 2019 10:32:52 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Sebastian Priebe <sebastian.priebe@de.sii.group>
Subject: Re: [PATCH nftables v2 1/2] cli: add linenoise CLI implementation.
Message-ID: <20191015083252.rm22hgssh4inezq4@salvia>
References: <20190924074055.4146-1-jeremy@azazel.net>
 <20190924074055.4146-2-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924074055.4146-2-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:40:54AM +0100, Jeremy Sowden wrote:
> By default, continue to use libreadline, but if `--with-cli=linenoise`
> is passed to configure, build the linenoise implementation instead.

Applied, thanks Jeremy.
