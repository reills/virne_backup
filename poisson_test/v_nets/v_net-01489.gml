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
  id 1489
  arrival_time 32943.774448376615
  lifetime 1659.136963460256
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 17
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 10
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 49
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 6
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 45
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 22
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 43
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 5
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 22
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 7
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 19
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 48
    gpu 27
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 31
    gpu 11
    rom 49
  ]
  node [
    id 13
    label "13"
    cpu 25
    gpu 44
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
  edge [
    source 12
    target 13
    bw 12
  ]
]
