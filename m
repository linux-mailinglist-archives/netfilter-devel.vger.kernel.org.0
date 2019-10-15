Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA17D73DC
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfJOKtr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 06:49:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54071 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbfJOKtr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:49:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so20318205wmd.3
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 03:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=63Q5ZtKDZ7TKoHwo6CChQ5Xt+PGkutFlk1aqwmSYJlU=;
        b=f0/Z5q38eEkXsWMTBZDi3HjmB1mclz7d5xbFjWtSpYW0Q0p0+/IXBatLQtk3k33EZ1
         4Yhi+z2oECv22H2ofuQQo98EDQdKUvOSOA3/uiOnp/e4Zkb7EV2oQpV8aeRd5TrGv82o
         kc7Bf96BHglJqR/uylVCybKTTjfwHK9DfXYPkkCuwaBn11vKSNucgNsoDtjcvfBktGAl
         /fGJg85QnqtK6fI/Qegl/1RWzK4d1T+UvsfC8Os9NRYQC4xC0aTDwfA+nHSNZ6BvDvDb
         2NdgW2i5hbXZXD+7HSF7Q/e28H+JsZKNstlft7Gkt4tuXMFBoX7XKJ8wly+HaSQMI1FX
         4onQ==
X-Gm-Message-State: APjAAAVEznfCU1unHKoab6KYYmZuXtXWtSKxJYWiMkNj5O0irA2xA+LN
        75eqRNgwxqGIlEzEUIEHymqa6HciqwE=
X-Google-Smtp-Source: APXvYqwS8BGffoZmC7AtlHP+qW/5TCwOJQyV85uM6Yp4PCuWD3oCEIHy+YcrS4CJnyA/uTY9d72DsA==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr19406365wmh.96.1571136584982;
        Tue, 15 Oct 2019 03:49:44 -0700 (PDT)
Received: from [192.168.1.156] (static.137.137.194.213.ibercom.com. [213.194.137.137])
        by smtp.gmail.com with ESMTPSA id 59sm46203334wrc.23.2019.10.15.03.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 03:49:44 -0700 (PDT)
Subject: Re: First Contribution
To:     UDAY MEWADA <udaymewada1@gmail.com>
References: <CAA6WKfwC-pqFPCmsFnCDaRzvzxk7CuGw+7RW-rMu60=UOCB2Cw@mail.gmail.com>
Cc:     netfilter-devel@vger.kernel.org
From:   Arturo Borrero Gonzalez <arturo@netfilter.org>
Openpgp: preference=signencrypt
Autocrypt: addr=arturo@netfilter.org; keydata=
 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
 EXgmBmyUKrJkh/zvupp9t9Y2ioPbcMObRIEXio4=
Message-ID: <817c386a-ec6b-6d01-b50f-7f7ea6aee8a1@netfilter.org>
Date:   Tue, 15 Oct 2019 12:49:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAA6WKfwC-pqFPCmsFnCDaRzvzxk7CuGw+7RW-rMu60=UOCB2Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 10/14/19 5:14 PM, UDAY MEWADA wrote:
> Hi all !
> My name is Uday Mewada, pursuing engineering in Computer Science.
> 
> I'm looking forward to contributing to Netfilter. Can someone guide me
> how to start contributing in it and what are the initial bugs where I
> can start.
> 

Welcome!

Please read this!

https://wiki.nftables.org/wiki-nftables/index.php/Portal:DeveloperDocs/Contributing
