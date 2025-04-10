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
  id 109
  arrival_time 2021.0208035256112
  lifetime 179.94319169982856
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 33
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 49
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 0
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 17
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 9
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 34
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 29
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 35
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 32
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 9
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 23
  ]
]
