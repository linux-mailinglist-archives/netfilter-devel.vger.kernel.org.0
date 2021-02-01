Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB38130A07B
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Feb 2021 04:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBADNe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 31 Jan 2021 22:13:34 -0500
Received: from correo.us.es ([193.147.175.20]:38780 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhBADNd (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 31 Jan 2021 22:13:33 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7E07DDA7E8
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Feb 2021 04:12:52 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 70576DA704
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Feb 2021 04:12:52 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 65FBDDA72F; Mon,  1 Feb 2021 04:12:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 457A3DA704;
        Mon,  1 Feb 2021 04:12:48 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 01 Feb 2021 04:12:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1DBDA426CC84;
        Mon,  1 Feb 2021 04:12:48 +0100 (CET)
Date:   Mon, 1 Feb 2021 04:12:47 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [conntrack-tools PATCH] conntrackd: introduce yes & no config
 values
Message-ID: <20210201031247.GA20742@salvia>
References: <161114994034.48299.3516818154943179595.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161114994034.48299.3516818154943179595.stgit@endurance>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jan 20, 2021 at 02:39:00PM +0100, Arturo Borrero Gonzalez wrote:
> They are equivalent of 'on' and 'off' and makes the config easier to understand.

LGTM.

Please, push it out.

Thanks.
