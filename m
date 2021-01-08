Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB5A2EF2AB
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Jan 2021 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhAHMwM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Jan 2021 07:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhAHMwM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:52:12 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFCDC0612F4
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Jan 2021 04:51:31 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id t3so6010233ilh.9
        for <netfilter-devel@vger.kernel.org>; Fri, 08 Jan 2021 04:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=ZPLbAmDSdN9gytA2Mg6XzGXRjKOCL7kdkZJuvLt73/ZFLUiZoWRfI99EDF8Q7sM6Ms
         /tY5gTSJF4yT9FXyr7c/aQDzeBzftlPxcw8bxDkKSZ/c3Oaqn3Nce1OMdn1GDnebCcWs
         IaUbDeYlTz/T/CR18LhvY2dye8l01AXBrFehZEzeSjJHaLHTVsGroacoPUTDUs/2lEYO
         oWxz4e6JbYiTBTjIAOUmEn/hKNkaBXbidJnr4kwYBSUUO6sgrNz3FDXBjpCatGgvxLWx
         4cieEmdIvNxh5MUFmI+eCdq2Ug8ki6Cj0TxDMjWzAtc9YPZLEOVfYzcdzUU1AUd2p1Dw
         6p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=clCiUjr3NAdbsoshoZRr4wizj5L/N+UfDG/wCYqobdGzeVHWiOen1nRji7ojjRrVmc
         o8gcJD1YIixYIX9yn7xrThEbhc9O/BpZ/nflPGpTsOP0z76mw6ArMeDOrf5Lj460/8bF
         WBJQ5gIiCwcgqBjRBmLtMP/yeon0XxU6pVaivdqyT84UK0AYWfQDGbvvhcGUtCcfYQPF
         rpLGFj3ZUxVH25zkE+S4zqOwpboNlZak1yHqmtTWM05usFQufJHTn8TLIG9emJ5fvqvJ
         oJu2aWE4ngCb7io66cyzkf/lJJA+4qBYwD/6HJ2SuAH1Z5pnZbRAtu9QKTXRpW4/SzT/
         6LdA==
X-Gm-Message-State: AOAM532IsiaxeVraQeJeV4gPNV1PYYGgFSqkhqsh093zpyApHF7R39y9
        HSERnVfZI8aKxIS1ZfnISSVhQyyPxZDfe9Yye6CvsdLR
X-Google-Smtp-Source: ABdhPJx/N4iyyJV0zD7MS8C300WZVFYYFWNQvubc+YwpY0mQnr5rNc5kRHP2xMBzbSlXfvqIYlPFA1YThr6TVymRgDY=
X-Received: by 2002:a05:6e02:1a4d:: with SMTP id u13mr3819596ilv.244.1610110291272;
 Fri, 08 Jan 2021 04:51:31 -0800 (PST)
MIME-Version: 1.0
Sender: batouziberth@gmail.com
Received: by 2002:a4f:1b10:0:0:0:0:0 with HTTP; Fri, 8 Jan 2021 04:51:30 -0800 (PST)
In-Reply-To: <CAMppdSy3w6-UfydAH798h1=Bod0wo0RVMaQphkoLSY0X4ik+Zw@mail.gmail.com>
References: <CAMppdSy3w6-UfydAH798h1=Bod0wo0RVMaQphkoLSY0X4ik+Zw@mail.gmail.com>
From:   camille <camillejackson021@gmail.com>
Date:   Fri, 8 Jan 2021 12:51:30 +0000
X-Google-Sender-Auth: VeKgZ2CPJ_wnkl20sIMj9io2koY
Message-ID: <CAMppdSws020zMP19jxqNRRxawBfdq-53XXQCnLUgL3Mk5gc5Jw@mail.gmail.com>
Subject: =?UTF-8?B?0JfQtNGA0LDQstGB0YLQstGD0LnRgtC1LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDRgtC10LHRjywg0LzQvtC5INC00YDRg9CzLCDQvdCw0LTQ
tdGO0YHRjCwg0YLRiyDQsiDQv9C+0YDRj9C00LrQtSwg0L/QvtC20LDQu9GD0LnRgdGC0LAsINC+
0YLQstC10YLRjCDQvNC90LUNCtCx0LvQsNCz0L7QtNCw0YDRjywNCg==
