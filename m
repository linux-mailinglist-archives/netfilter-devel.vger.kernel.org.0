Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316FD12CFBF
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Dec 2019 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfL3Lv2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Dec 2019 06:51:28 -0500
Received: from correo.us.es ([193.147.175.20]:46222 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfL3Lv2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:51:28 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1C53EEB910
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Dec 2019 12:51:26 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0FAC3DA709
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Dec 2019 12:51:26 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 04FD1DA703; Mon, 30 Dec 2019 12:51:26 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 188A3DA70F;
        Mon, 30 Dec 2019 12:51:24 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Dec 2019 12:51:24 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [185.124.28.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B69A242EE38E;
        Mon, 30 Dec 2019 12:51:23 +0100 (CET)
Date:   Mon, 30 Dec 2019 12:51:20 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 2/2] doc: doxygen.cfg.in: Eliminate 20
 doxygen warnings
Message-ID: <20191230115120.jh2hwff2esykycon@salvia>
References: <20191223013607.26276-1-duncan_roe@optusnet.com.au>
 <20191223013607.26276-2-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223013607.26276-2-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 23, 2019 at 12:36:07PM +1100, Duncan Roe wrote:
> - Add 5 opaque or internal items to the EXCLUDE_SYMBOLS list
> - Remove 4 obsolete configuration lines

Applied, thanks.
