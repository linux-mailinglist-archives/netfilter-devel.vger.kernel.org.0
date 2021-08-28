Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1663FA773
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 21:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhH1TyN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhH1TyM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:54:12 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AACC061756
        for <netfilter-devel@vger.kernel.org>; Sat, 28 Aug 2021 12:53:21 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 03C2C59BB01EA; Sat, 28 Aug 2021 21:53:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 0010C60C43D95;
        Sat, 28 Aug 2021 21:53:19 +0200 (CEST)
Date:   Sat, 28 Aug 2021 21:53:19 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_log 0/6] Implementation of some fields
 omitted by `ipulog_get_packet`.
In-Reply-To: <20210828193824.1288478-1-jeremy@azazel.net>
Message-ID: <5n2q9rr7-p920-pro6-3nn2-pn5qps91so64@vanv.qr>
References: <20210828193824.1288478-1-jeremy@azazel.net>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Saturday 2021-08-28 21:38, Jeremy Sowden wrote:

>Jeremy Sowden (6):
>  Add doxygen directory to .gitignore.
>  build: remove references to non-existent man-pages.
>  doc: fix typo's in example.
>  src: use calloc instead of malloc + memset.
>  libipulog: use correct index to find attribute in packet.
>  libipulog: fill in missing packet fields.

Subjects are not full sentences, as such they should never contain 
trailing periods.
