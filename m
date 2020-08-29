Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62872256717
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 Aug 2020 13:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgH2L3k (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 29 Aug 2020 07:29:40 -0400
Received: from correo.us.es ([193.147.175.20]:45292 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgH2L2y (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:28:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DEA06D1626
        for <netfilter-devel@vger.kernel.org>; Sat, 29 Aug 2020 13:17:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D16E6DA73D
        for <netfilter-devel@vger.kernel.org>; Sat, 29 Aug 2020 13:17:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C7136DA730; Sat, 29 Aug 2020 13:17:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DAA4DDA722;
        Sat, 29 Aug 2020 13:17:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 29 Aug 2020 13:17:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B1E8742EF4E0;
        Sat, 29 Aug 2020 13:17:37 +0200 (CEST)
Date:   Sat, 29 Aug 2020 13:17:37 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Balazs Scheidler <bazsi77@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables v2 3/5] doc: added documentation on "socket
 wildcard"
Message-ID: <20200829111737.GC9645@salvia>
References: <20200829070405.23636-1-bazsi77@gmail.com>
 <20200829070405.23636-4-bazsi77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829070405.23636-4-bazsi77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Applied, thanks.
