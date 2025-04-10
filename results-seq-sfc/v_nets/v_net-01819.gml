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
  id 1819
  arrival_time 40289.321305579426
  lifetime 163.1906936316188
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 14
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 7
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 39
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 18
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 18
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 15
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 19
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 31
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 25
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 34
    rom 29
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 32
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 20
    rom 21
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 20
    rom 16
  ]
  node [
    id 13
    label "13"
    cpu 1
    gpu 41
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
  edge [
    source 12
    target 13
    bw 33
  ]
]
