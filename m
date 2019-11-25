Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7C109527
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Nov 2019 22:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKYVaz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Nov 2019 16:30:55 -0500
Received: from correo.us.es ([193.147.175.20]:47126 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfKYVaz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Nov 2019 16:30:55 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 905E8E8640
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2019 22:30:51 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 777F33A22A
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2019 22:30:51 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C2089A7DC8; Mon, 25 Nov 2019 22:30:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D8AFCA7DCB;
        Mon, 25 Nov 2019 22:30:41 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 25 Nov 2019 22:30:41 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B328741E4800;
        Mon, 25 Nov 2019 22:30:41 +0100 (CET)
Date:   Mon, 25 Nov 2019 22:30:43 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] doc: fix inconsistency in set statement
 documentation.
Message-ID: <20191125213043.zkkwfg6m7rned6v2@salvia>
References: <20191125205450.240041-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125205450.240041-1-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 25, 2019 at 08:54:50PM +0000, Jeremy Sowden wrote:
> The description of the set statement asserts that the set must have been
> created with the "dynamic" flag.  However, this is not in fact the case,
> and the assertion is contradicted by the following example, in which the
> set is created with just the "timeout" flag (which suffices to ensure
> that the kernel will create a set which can be updated).  Remove the
> assertion.

The timeout implies dynamic.

Without the timeout flag, you need the dynamic flag.

Do you want to keep supporting this scenario or probably this should
disallow set updates from the packet path with no timeout.
