Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCAE1F1FE7
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2020 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgFHT2y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Jun 2020 15:28:54 -0400
Received: from mail.thelounge.net ([91.118.73.15]:51055 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgFHT2y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:28:54 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 49gjwh02n0zXPN
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2020 21:28:51 +0200 (CEST)
From:   Reindl Harald <h.reindl@thelounge.net>
Subject: nf_defrag_ipv6 / ip6_udp_tunnel on pure ipv4 setups
Organization: the lounge interactive design
To:     netfilter-devel@vger.kernel.org
Message-ID: <6ce5eadf-e068-64f2-fd6e-1613f95b8e56@thelounge.net>
Date:   Mon, 8 Jun 2020 21:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

why are the ipv6 modules loaded on pure ipv4 setups and if they are
always needed why are they seperate modules?

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1

ip6_udp_tunnel         16384  1 wireguard
udp_tunnel             16384  1 wireguard

nf_defrag_ipv6         24576  1 nf_conntrack
nf_defrag_ipv4         16384  1 nf_conntrack
