graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1512
  arrival_time 33607.573109254656
  lifetime 2166.253602402444
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 40
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 8
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 15
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 36
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 5
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 20
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 4
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 39
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 45
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 30
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 9
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 36
    gpu 17
    rom 49
  ]
  node [
    id 12
    label "12"
    cpu 35
    gpu 38
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
  edge [
    source 11
    target 12
    bw 20
  ]
]
