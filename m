Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7E130555
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Jan 2020 02:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAEBVt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 4 Jan 2020 20:21:49 -0500
Received: from rain.florz.de ([185.139.32.146]:47141 "EHLO rain.florz.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgAEBVt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:21:49 -0500
Received: from [2a07:12c0:1c00:43::121] (port=59386 helo=florz.florz.de)
        by rain.florz.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA256:256)
        (Exim 4.92)
        (envelope-from <florz@florz.de>)
        id 1inuby-0004bl-VA
        for netfilter-devel@vger.kernel.org; Sun, 05 Jan 2020 02:21:47 +0100
Received: from florz by florz.florz.de with local (Exim 4.92)
        (envelope-from <florz@florz.de>)
        id 1inuby-0005Sl-HA
        for netfilter-devel@vger.kernel.org; Sun, 05 Jan 2020 02:21:46 +0100
Date:   Sun, 5 Jan 2020 02:21:46 +0100
From:   Florian Zumbiehl <florz@florz.de>
To:     netfilter-devel@vger.kernel.org
Subject: [nftables] bug: set output inconsistent syntax and missing
 information
Message-ID: <20200105012145.GF3854@florz.florz.de>
Mail-Followup-To: netfilter-devel@vger.kernel.org, florz@florz.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

... and then I stumbled upon yet another bug:

| # nft 'table ip foobartest { set s { type ipv4_addr; flags interval,timeout; elements={ 0.0.0.0/0 timeout 1d comment foo }; }; }'
| # nft list set foobartest s
| table ip foobartest {
|         set s {
|                 type ipv4_addr
|                 flags interval,timeout
|                 elements = { 0.0.0.0-255.255.255.255 }
|         }
| }

Any "trailing" ranges in a set that reach to the end of the address space are
(a) output as ranges rather than prefixes and (b) lack the comment and timeout
info.

My guess would be that that is due to the trailing special case at the end of
interval_map_decompose()?

Regards, Florian
