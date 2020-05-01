Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0711C19E1
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2020 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgEAPjh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 1 May 2020 11:39:37 -0400
Received: from a3.inai.de ([88.198.85.195]:51398 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbgEAPjh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 1 May 2020 11:39:37 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id E039E58723215; Fri,  1 May 2020 17:39:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DB3A960DE9179;
        Fri,  1 May 2020 17:39:33 +0200 (CEST)
Date:   Fri, 1 May 2020 17:39:33 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Reindl Harald <h.reindl@thelounge.net>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: strage iptables counts of wireguard traffic
In-Reply-To: <1aa3eccc-032c-118e-1a4f-c129508696c5@thelounge.net>
Message-ID: <nycvar.YFH.7.76.2005011738430.19024@n3.vanv.qr>
References: <1aa3eccc-032c-118e-1a4f-c129508696c5@thelounge.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Friday 2020-05-01 17:09, Reindl Harald wrote:

>how can it be that a single peer has 2.8 GB traffic and in the raw table
>the whole udp traffic is only 417M?

>iptables --verbose --list --table raw
>Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)

Uh that's the policy counter, not the entire-table counter.
