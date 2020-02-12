Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B664415B211
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Feb 2020 21:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLUpb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Feb 2020 15:45:31 -0500
Received: from correo.us.es ([193.147.175.20]:44522 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBLUpa (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:45:30 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6BAF1DA704
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Feb 2020 21:45:30 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D699DA703
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Feb 2020 21:45:30 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 529FDDA701; Wed, 12 Feb 2020 21:45:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7C6CDDA703;
        Wed, 12 Feb 2020 21:45:28 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 12 Feb 2020 21:45:28 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 551E142EF42A;
        Wed, 12 Feb 2020 21:45:28 +0100 (CET)
Date:   Wed, 12 Feb 2020 21:45:26 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Laurent Fasnacht <fasnacht@protonmail.ch>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft include v2 4/7] scanner: remove parser_state->indescs
 static array
Message-ID: <20200212204526.hcu56bkhqjjbdxn5@salvia>
References: <20200210101709.9182-1-fasnacht@protonmail.ch>
 <20200210101709.9182-5-fasnacht@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210101709.9182-5-fasnacht@protonmail.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:17:24AM +0000, Laurent Fasnacht wrote:
> This static array is redundant wth the indesc_list structure, but
> is less flexible.

Patches applied, from 3 to 7.

Thanks.
