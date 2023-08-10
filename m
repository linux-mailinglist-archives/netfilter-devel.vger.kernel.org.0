Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584BB7782D0
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Aug 2023 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjHJVst (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Aug 2023 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHJVst (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:48:49 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9FD2738
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Aug 2023 14:48:47 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id D8149587264C0; Thu, 10 Aug 2023 23:48:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id D73B960C28140;
        Thu, 10 Aug 2023 23:48:39 +0200 (CEST)
Date:   Thu, 10 Aug 2023 23:48:39 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Thomas Haller <thaller@redhat.com>
cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [nft PATCH] src: use reentrant 
 getprotobyname_r()/getprotobynumber_r()/getservbyport_r()
In-Reply-To: <20230810123035.3866306-1-thaller@redhat.com>
Message-ID: <o4o37q01-r4s6-o009-379n-rsr0n79817r0@vanv.qr>
References: <20230810123035.3866306-1-thaller@redhat.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Thursday 2023-08-10 14:30, Thomas Haller wrote:
> 
>+bool nft_getprotobyname(const char *name, uint8_t *out_proto);

Knowing that proto can only be uint8, why not make this work like
getc() where the return type is a type with a larger range?

int nft_getprotobyname(const char *name)
{
    workworkwork();
    if (error)
	return -1;
    return workresult;
}
