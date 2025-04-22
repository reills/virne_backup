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
  id 1253
  arrival_time 25914.661514804393
  lifetime 127.0006715143785
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 43
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 15
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 26
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 4
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 50
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 47
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 7
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 42
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 4
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 50
    rom 12
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 36
    rom 5
  ]
  node [
    id 11
    label "11"
    cpu 29
    gpu 22
    rom 18
  ]
  node [
    id 12
    label "12"
    cpu 33
    gpu 36
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
]
