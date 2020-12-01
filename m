Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04B02C99F3
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Dec 2020 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgLAIui (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Dec 2020 03:50:38 -0500
Received: from correo.us.es ([193.147.175.20]:53606 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbgLAIui (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:50:38 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9B1BB20A532
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Dec 2020 09:49:56 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 89DA211C361
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Dec 2020 09:49:56 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 88DFEDA73F; Tue,  1 Dec 2020 09:49:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 84AF2DA704;
        Tue,  1 Dec 2020 09:49:54 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 01 Dec 2020 09:49:54 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 675344265A5A;
        Tue,  1 Dec 2020 09:49:54 +0100 (CET)
Date:   Tue, 1 Dec 2020 09:49:55 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: use actual socket sk for REJECT action
Message-ID: <20201201084955.GC26468@salvia>
References: <20201121111151.15960-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201121111151.15960-1-jengelh@inai.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Jan,

On Sat, Nov 21, 2020 at 12:11:51PM +0100, Jan Engelhardt wrote:
> True to the message of commit v5.10-rc1-105-g46d6c5ae953c, _do_
> actually make use of state->sk when possible, such as in the REJECT
> modules.

Could you rebase and resend a v2? I think this patch is clashing with
recent updates to add REJECT support for ingress.

Thanks.
