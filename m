Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8A1585B9
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Feb 2020 23:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBJWqf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Feb 2020 17:46:35 -0500
Received: from correo.us.es ([193.147.175.20]:58906 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBJWqf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:46:35 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CA18AE8B6C
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Feb 2020 23:46:34 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BDD41DA702
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Feb 2020 23:46:34 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B3656DA703; Mon, 10 Feb 2020 23:46:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D9A00DA702;
        Mon, 10 Feb 2020 23:46:32 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 10 Feb 2020 23:46:32 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AF9F5426CCBA;
        Mon, 10 Feb 2020 23:46:32 +0100 (CET)
Date:   Mon, 10 Feb 2020 23:46:31 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Laurent Fasnacht <fasnacht@protonmail.ch>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft include v2 2/7] scanner: move the file descriptor to
 be in the input_descriptor structure
Message-ID: <20200210224631.2mbyogvlbpn264uy@salvia>
References: <20200210101709.9182-1-fasnacht@protonmail.ch>
 <20200210101709.9182-3-fasnacht@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210101709.9182-3-fasnacht@protonmail.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:17:21AM +0000, Laurent Fasnacht wrote:
> This prevents a static allocation of file descriptors array, thus allows
> more flexibility.

This one is applied, thanks.
