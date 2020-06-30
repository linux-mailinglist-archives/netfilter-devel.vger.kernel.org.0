Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F294220F9AE
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2020 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbgF3Qn4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Jun 2020 12:43:56 -0400
Received: from correo.us.es ([193.147.175.20]:56144 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733117AbgF3Qn4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:43:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C153AF2588
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Jun 2020 18:43:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B1FFADA8E8
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Jun 2020 18:43:54 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A79ECDA722; Tue, 30 Jun 2020 18:43:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A628ADA8E8;
        Tue, 30 Jun 2020 18:43:52 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 30 Jun 2020 18:43:52 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 891BB4265A2F;
        Tue, 30 Jun 2020 18:43:52 +0200 (CEST)
Date:   Tue, 30 Jun 2020 18:43:52 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Laura Garcia Liebana <nevola@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, devel@zevenet.com
Subject: Re: [PATCH v3 nf-next] netfilter: introduce support for reject at
 prerouting stage
Message-ID: <20200630164352.GA25902@salvia>
References: <20200531202623.GA27861@nevthink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531202623.GA27861@nevthink>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, May 31, 2020 at 10:26:23PM +0200, Laura Garcia Liebana wrote:
> REJECT statement can be only used in INPUT, FORWARD and OUTPUT
> chains. This patch adds support of REJECT, both icmp and tcp
> reset, at PREROUTING stage.
> 
> The need for this patch comes from the requirement of some
> forwarding devices to reject traffic before the natting and
> routing decisions.
> 
> The main use case is to be able to send a graceful termination
> to legitimate clients that, under any circumstances, the NATed
> endpoints are not available. This option allows clients to
> decide either to perform a reconnection or manage the error in
> their side, instead of just dropping the connection and let
> them die due to timeout.
> 
> It is supported ipv4, ipv6 and inet families for nft
> infrastructure.

Applied, thanks Laura.
