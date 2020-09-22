Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B198E274ADE
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Sep 2020 23:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIVVKx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Sep 2020 17:10:53 -0400
Received: from correo.us.es ([193.147.175.20]:51596 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgIVVKx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:10:53 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 727CF9D3D5
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 23:10:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 63522DA704
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 23:10:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 56046DA73D; Tue, 22 Sep 2020 23:10:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2880FDA704;
        Tue, 22 Sep 2020 23:10:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 22 Sep 2020 23:10:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 00A6742EFB80;
        Tue, 22 Sep 2020 23:10:49 +0200 (CEST)
Date:   Tue, 22 Sep 2020 23:10:49 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Gopal <gopunop@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] Solves Bug 1388 - Combining --terse with --json has no
 effect (with test)
Message-ID: <20200922211049.GA31330@salvia>
References: <20200922082533.20920-1-gopunop@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922082533.20920-1-gopunop@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:55:33PM +0530, Gopal wrote:
> From: Gopal Yadav <gopunop@gmail.com>
> 
> Solves Bug 1388 - Combining --terse with --json has no effect (with test)

Applied, thanks.
