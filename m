Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F5798608
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Sep 2023 12:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbjIHKnt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Sep 2023 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIHKns (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E01BEE
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Sep 2023 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694169781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pp8Qql0ZoiU8c5rXXuzZad22BjomYHstHEwHKnOLXGw=;
        b=VgSI4Ya8vAD6qnPMwiPls8ZtNdb128czkr0hEMCO4Or+Y68nbITLnXrNGu2STSrcPqFJ7h
        1ziYkSylHotEqc9WQjtrDMCdWbv0jewnZ6f2sBquvIuDHsS2Rx1fnDBCs/xqSBgElZrWDC
        n5SmBR5OFLLlIc47L5QB6InlVA6ITkI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-jKx-okFKO_iJRl79iBGjKw-1; Fri, 08 Sep 2023 06:43:00 -0400
X-MC-Unique: jKx-okFKO_iJRl79iBGjKw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31de5f9d843so297014f8f.1
        for <netfilter-devel@vger.kernel.org>; Fri, 08 Sep 2023 03:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694169779; x=1694774579;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pp8Qql0ZoiU8c5rXXuzZad22BjomYHstHEwHKnOLXGw=;
        b=Mp5vSrT+jwuMe9ixmg47NLZhs63XjZ+HkG7oxuyDSc2R5K0oZkw8+8U/QaxOzDwSNi
         0Oie1gv345VVFzJDEOqaWd3g+9qFAdQew9fWgg+iQwLJlYYi/9mHhZY4k7C/IQK0P+Ce
         g4qsf06x3IbgBeIqxtc/ACaycpjclVTeLxQmBSnR+JZHrI8jF9OQ7nKohMU7lmmLw46U
         CPJawZj4EJab+SUtGvn4f8lx+T70c7PinT6H+Y55lfmUJPSRsNT3Voa21Hk8vnNJhgAd
         PnRTJ6Q7TJA3gS29jDhgywqM6hJwFAeN4DPmGBoYaNZaFnn4Do2duN2fKL5rJqmTZWNz
         UveA==
X-Gm-Message-State: AOJu0YyWE/FA1M57BdJE7BhBfWWAcIolNW1oRBf0eRf9QYtP3CisMKYZ
        ynY+MykDrYFWEqR9cm6Ptb9y7OkoJRRm7jma6eEIrYoqOtbmlOmgr/XW6kfu3yoeiPloKx7LC5Q
        zij+jNgjrlknPNu9iy2oEQCZ3SfqCNM2gxU+5
X-Received: by 2002:a5d:5702:0:b0:317:5f08:329f with SMTP id a2-20020a5d5702000000b003175f08329fmr1698912wrv.1.1694169779132;
        Fri, 08 Sep 2023 03:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiasS82exfYJ5YdcrNwYGdX1DeXGxxPFi3u91fVJVcIpXdkDdEGHPJPvuirZwf+pve8Z+ydg==
X-Received: by 2002:a5d:5702:0:b0:317:5f08:329f with SMTP id a2-20020a5d5702000000b003175f08329fmr1698901wrv.1.1694169778791;
        Fri, 08 Sep 2023 03:42:58 -0700 (PDT)
Received: from [10.0.0.168] ([37.186.167.86])
        by smtp.gmail.com with ESMTPSA id p13-20020adff20d000000b003176eab8868sm1768793wro.82.2023.09.08.03.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:42:58 -0700 (PDT)
Message-ID: <65b038a11c1168a829a19e309bd174a9e01ae2d1.camel@redhat.com>
Subject: Re: [PATCH nft 2/2] tests/shell: add missing ".nodump" file for
 tests without dumps
From:   Thomas Haller <thaller@redhat.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Date:   Fri, 08 Sep 2023 12:42:57 +0200
In-Reply-To: <20230908102226.GA6592@breakpoint.cc>
References: <20230907210558.2410789-1-thaller@redhat.com>
         <20230907210558.2410789-2-thaller@redhat.com>
         <20230908102226.GA6592@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, 2023-09-08 at 12:22 +0200, Florian Westphal wrote:
> Thomas Haller <thaller@redhat.com> wrote:
> > These files are generated by running=C2=A0 `./tests/shell/run-tests.sh =
-
> > g`.
> > Commit the .nodump files to git.
> >=20
> > The point is that we can in the future run `./tests/shell/run-
> > tests.sh
> > -g` and don't get an abundance of irrelevant dump files generated.
> >=20
> > This raises the question, whether some of these tests should
> > actually
> > have their ruleset compared against a .nft file. But this is
> > nothing
> > new and not prevented by this change. The change merely expresses
> > in
> > clear way that those tests are (currently) meant not to have .nft
> > files.
>=20
> I think it would be preferrable to have a patch 2/3 that first adds
> new .nft dump files for all tests where the output is stable, and
> then
> only add the .nodump files (this patch) for those where dump
> validation
> cannot work.
>=20
> I suspect that most will pass as expected.
> Even an empty dump file can be useful because this would catch
> (unlikely) bugs with delete/flush failure.
>=20
> We could simplify some scripts later on, some of the no-dump scripts
> manually validate output, that isn't needed anymore after this.
>=20


Makes sense. Will do.

Thomas

