Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1A326F10
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Feb 2021 22:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhB0Vga (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 27 Feb 2021 16:36:30 -0500
Received: from correo.us.es ([193.147.175.20]:52256 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhB0Vg2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 27 Feb 2021 16:36:28 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D35D715C102
        for <netfilter-devel@vger.kernel.org>; Sat, 27 Feb 2021 22:35:42 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C027DDA73F
        for <netfilter-devel@vger.kernel.org>; Sat, 27 Feb 2021 22:35:42 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B568EDA73D; Sat, 27 Feb 2021 22:35:42 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.3 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9D0DADA704;
        Sat, 27 Feb 2021 22:35:40 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 27 Feb 2021 22:35:40 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7637542DC6E3;
        Sat, 27 Feb 2021 22:35:40 +0100 (CET)
Date:   Sat, 27 Feb 2021 22:35:40 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Klemen =?utf-8?B?S2/FoWly?= <klemen.kosir@kream.io>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: Remove a double space in a log message
Message-ID: <20210227213540.GA16088@salvia>
References: <20210220092926.12025-1-klemen.kosir@kream.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210220092926.12025-1-klemen.kosir@kream.io>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Feb 20, 2021 at 06:29:26PM +0900, Klemen Košir wrote:
> Removed an extra space in a log message and an extra blank line in code.

Applied, thanks.
