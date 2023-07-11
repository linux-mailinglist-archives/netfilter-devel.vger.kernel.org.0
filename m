Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA8D74E74E
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Jul 2023 08:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGKG1t (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Jul 2023 02:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGKG1s (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:27:48 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5254116
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jul 2023 23:27:46 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 1987458733E81; Tue, 11 Jul 2023 08:27:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 18D9660BF4F0C;
        Tue, 11 Jul 2023 08:27:45 +0200 (CEST)
Date:   Tue, 11 Jul 2023 08:27:45 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Philip Prindeville <philipp@redfish-solutions.com>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/1] xt_asn: support quiet mode
In-Reply-To: <20230710044718.2682302-1-philipp@redfish-solutions.com>
Message-ID: <695806p-1nos-43ps-7rs8-nrnpor8r6r73@vanv.qr>
References: <20230710044718.2682302-1-philipp@redfish-solutions.com>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Monday 2023-07-10 06:47, Philip Prindeville wrote:
>Signed-off-by: Philip Prindeville <philipp@redfish-solutions.com>

Both applied.
