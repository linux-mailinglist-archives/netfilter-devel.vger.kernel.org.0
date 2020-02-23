Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9E4169A59
	for <lists+netfilter-devel@lfdr.de>; Sun, 23 Feb 2020 22:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWVvP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 Feb 2020 16:51:15 -0500
Received: from correo.us.es ([193.147.175.20]:53564 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWVvO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 Feb 2020 16:51:14 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 33842EBAC3
        for <netfilter-devel@vger.kernel.org>; Sun, 23 Feb 2020 22:51:08 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2546BDA72F
        for <netfilter-devel@vger.kernel.org>; Sun, 23 Feb 2020 22:51:08 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1A9A8DA788; Sun, 23 Feb 2020 22:51:08 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 557DFDA72F;
        Sun, 23 Feb 2020 22:51:06 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 23 Feb 2020 22:51:06 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 30CC142EF4E1;
        Sun, 23 Feb 2020 22:51:06 +0100 (CET)
Date:   Sun, 23 Feb 2020 22:51:10 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Andreas Jaggi <andreas.jaggi@waterwave.ch>
Cc:     Netfilter Development Mailing list 
        <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH] ulogd: printpkt: always print IPv6 protocol
Message-ID: <20200223215110.7zbxe3tyiisythf3@salvia>
References: <12B140AA-502D-488F-B6A2-9E9DCF1DFC71@waterwave.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12B140AA-502D-488F-B6A2-9E9DCF1DFC71@waterwave.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 21, 2020 at 07:40:36AM +0100, Andreas Jaggi wrote:
> Print the protocol number for protocols not known by name.

Applied, thanks.
