Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184A1409A8D
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Sep 2021 19:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbhIMRVR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Sep 2021 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhIMRVQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:21:16 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCCCC061574
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Sep 2021 10:19:59 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 3274D586B1ADE; Mon, 13 Sep 2021 19:19:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 2EFDD6168D59E;
        Mon, 13 Sep 2021 19:19:55 +0200 (CEST)
Date:   Mon, 13 Sep 2021 19:19:55 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>, kaskada@email.cz
Subject: Re: [xtables-addons 0/4] IPv6 support for xt_ipp2p
In-Reply-To: <20210913092051.79743-1-jeremy@azazel.net>
Message-ID: <83548n8s-q86s-7ps7-p054-n887o729o629@vanv.qr>
References: <20210913092051.79743-1-jeremy@azazel.net>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Monday 2021-09-13 11:20, Jeremy Sowden wrote:

>* The first patch short-circuits searches if the packet is empty.
>* The second and third patches refactor the ipv4 code in anticipation of
>  adding ipv6 support.
>* The fourth patch adds ipv6 support.

Added it.
