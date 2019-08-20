Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6849681F
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Aug 2019 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfHTR5G (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Aug 2019 13:57:06 -0400
Received: from correo.us.es ([193.147.175.20]:37192 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHTR5G (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:57:06 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 93BE5DA737
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Aug 2019 19:57:03 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 855F7B7FFB
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Aug 2019 19:57:03 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7AEB1B7FF9; Tue, 20 Aug 2019 19:57:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 86775B7FF6;
        Tue, 20 Aug 2019 19:57:01 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 20 Aug 2019 19:57:01 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [47.60.43.0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 552E94265A2F;
        Tue, 20 Aug 2019 19:57:01 +0200 (CEST)
Date:   Tue, 20 Aug 2019 19:57:00 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] src: add vlan_id type
Message-ID: <20190820175700.pqgx3hn4h6eztdjt@salvia>
References: <20190820164523.18464-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820164523.18464-1-michael-dev@fami-braun.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 20, 2019 at 06:45:23PM +0200, Michael Braun wrote:
> This enables using vlan id in a set or a concatenation.
> 
> table bridge filter {
> 	set dropvlans {
> 		type vlan_id
> 		elements = { 123 }
> 	}
> 	chain FORWARD {
> 		type filter hook forward priority filter; policy accept;
>                 vlan id @dropvlans drop
> 	}
> }

Thanks for submitting your patch.

Florian sent a better approach to support for all types generically.
Please, have a look at his recent typeof() series.
